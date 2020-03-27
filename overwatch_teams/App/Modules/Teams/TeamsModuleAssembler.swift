import UIKit

final class TeamsModuleAssembler {
    func assemble(currentNavigation: UINavigationController) -> UIViewController {
        
        let viewController = TeamsViewControllerImp.init(teamsView: TeamsViewImp())
        
        let realm = RealmFactory().createInstance()
        let repository = TeamsRealmRepository(realm: realm)
        let service: TeamsWebService = WebServiceFactory().createTeamsWebService()
        let useCases = TeamsUseCasesImp(service: service, repository: repository)
        
        let router = TeamsRouterImp(currentNavigation: currentNavigation)
        
        let presenter = TeamsPresenterImp(
            viewController: viewController,
            teamsUseCases: useCases,
            router: router
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}

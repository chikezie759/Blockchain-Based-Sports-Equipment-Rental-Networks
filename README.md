# Blockchain-Based Sports Equipment Rental Networks

A comprehensive blockchain solution for sports equipment rental management built on the Stacks blockchain using Clarity smart contracts.

## Overview

This project implements a decentralized sports equipment rental network that enables secure, transparent, and community-driven equipment sharing. The system consists of five interconnected smart contracts that handle different aspects of the rental ecosystem.

## Features

### 🔐 Equipment Owner Verification
- Secure registration and verification of equipment owners
- Equipment registry with detailed specifications
- Owner reputation tracking and verification status

### 🏠 Rental Management
- Flexible rental agreement creation and management
- Dynamic pricing and availability controls
- Automated deposit and payment handling
- Rental status tracking and completion

### 🔧 Maintenance Tracking
- Comprehensive maintenance history recording
- Scheduled maintenance reminders
- Certified technician verification
- Equipment condition monitoring

### 🛡️ Insurance Coordination
- Equipment insurance policy management
- Claims filing and processing system
- Coverage validation and verification
- Multi-provider insurance support

### 👥 Community Building
- Member registration and reputation system
- Peer review and rating system
- Community event organization
- Tiered membership levels (Bronze, Silver, Gold, Platinum)

## Smart Contracts

### 1. Equipment Verification Contract (\`equipment-verification.clar\`)
Manages equipment owner registration, verification, and equipment registry.

**Key Functions:**
- \`register-owner\`: Register as an equipment owner
- \`verify-owner\`: Admin function to verify owners
- \`register-equipment\`: Register sports equipment
- \`get-owner-info\`: Retrieve owner information
- \`get-equipment-info\`: Retrieve equipment details

### 2. Rental Management Contract (\`rental-management.clar\`)
Handles equipment listings, rental agreements, and rental lifecycle management.

**Key Functions:**
- \`list-equipment\`: List equipment for rent
- \`create-rental\`: Create rental agreements
- \`complete-rental\`: Complete rental transactions
- \`get-rental-info\`: Retrieve rental details
- \`get-equipment-availability\`: Check equipment availability

### 3. Maintenance Tracking Contract (\`maintenance-tracking.clar\`)
Tracks equipment maintenance history and schedules future maintenance.

**Key Functions:**
- \`record-maintenance\`: Record completed maintenance
- \`schedule-maintenance\`: Schedule future maintenance
- \`get-maintenance-record\`: Retrieve maintenance records
- \`get-maintenance-status\`: Check maintenance status
- \`is-maintenance-due\`: Check if maintenance is due

### 4. Insurance Coordination Contract (\`insurance-coordination.clar\`)
Manages insurance policies and claims for rental equipment.

**Key Functions:**
- \`create-policy\`: Create insurance policies
- \`file-claim\`: File insurance claims
- \`process-claim\`: Admin function to process claims
- \`get-policy-info\`: Retrieve policy information
- \`get-claim-info\`: Retrieve claim details

### 5. Community Building Contract (\`community-building.clar\`)
Builds and manages the sports equipment sharing community.

**Key Functions:**
- \`join-community\`: Join the community
- \`submit-review\`: Submit peer reviews
- \`create-event\`: Create community events
- \`join-event\`: Join community events
- \`get-member-info\`: Retrieve member information

## Getting Started

### Prerequisites
- Stacks blockchain node or access to testnet
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/your-repo/sports-equipment-rental
   cd sports-equipment-rental
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

1. Deploy contracts to Stacks testnet:
   \`\`\`bash
   clarinet deploy --testnet
   \`\`\`

2. Verify contract deployment:
   \`\`\`bash
   clarinet console
   \`\`\`

## Usage Examples

### Register as Equipment Owner
\`\`\`clarity
(contract-call? .equipment-verification register-owner)
\`\`\`

### Register Equipment
\`\`\`clarity
(contract-call? .equipment-verification register-equipment "Bicycle" "Trek" "Mountain Bike Pro")
\`\`\`

### List Equipment for Rent
\`\`\`clarity
(contract-call? .rental-management list-equipment u1 u50 u1 u30)
\`\`\`

### Create Rental Agreement
\`\`\`clarity
(contract-call? .rental-management create-rental u1 u7)
\`\`\`

### Join Community
\`\`\`clarity
(contract-call? .community-building join-community)
\`\`\`

## Testing

The project includes comprehensive test suites for all contracts using Vitest:

- \`tests/equipment-verification.test.js\`
- \`tests/rental-management.test.js\`
- \`tests/maintenance-tracking.test.js\`
- \`tests/insurance-coordination.test.js\`
- \`tests/community-building.test.js\`

Run all tests:
\`\`\`bash
npm test
\`\`\`

Run specific test file:
\`\`\`bash
npm test tests/equipment-verification.test.js
\`\`\`

## Architecture

The system follows a modular architecture with clear separation of concerns:

1. **Verification Layer**: Handles identity and equipment verification
2. **Business Logic Layer**: Manages rentals, maintenance, and insurance
3. **Community Layer**: Facilitates community interaction and reputation
4. **Data Layer**: Persistent storage using Clarity maps

## Security Considerations

- All functions include proper authorization checks
- Input validation prevents invalid data entry
- Role-based access control for administrative functions
- Deposit system protects against equipment damage
- Insurance integration provides additional protection

## Roadmap

- [ ] Integration with IoT devices for real-time equipment monitoring
- [ ] Mobile application for easier access
- [ ] Integration with external payment systems
- [ ] Advanced analytics and reporting features
- [ ] Multi-chain deployment support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue on GitHub
- Join our community Discord
- Email: support@sportsequipmentrental.com

## Acknowledgments

- Stacks Foundation for blockchain infrastructure
- Clarity language documentation and community
- Open source contributors and testers
  \`\`\`
  \`\`\`

Finally, let's create the PR details file:

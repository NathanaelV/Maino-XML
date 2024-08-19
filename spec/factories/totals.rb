FactoryBot.define do
  factory :total do
    einvoice { nil }
    v_icms { 'MyString' }
    v_ipi { 'MyString' }
    v_pis { 'MyString' }
    v_cofins { 'MyString' }
    v_nf { 'MyString' }
    v_tot_trib { 'MyString' }
  end
end

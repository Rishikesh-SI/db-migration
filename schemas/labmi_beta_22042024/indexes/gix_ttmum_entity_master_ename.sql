-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labmi_beta_22042024.labmi_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

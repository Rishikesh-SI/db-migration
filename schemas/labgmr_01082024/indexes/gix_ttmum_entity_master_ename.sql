-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labgmr_01082024.labgmr_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

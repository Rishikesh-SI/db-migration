-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: gix_mum_entity_master_ename
-- Type: INDEX

-- Name: gix_mum_entity_master_ename; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX gix_mum_entity_master_ename ON dhm.dhm_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

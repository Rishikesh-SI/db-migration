-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: gix_cfc_entity_master_ename
-- Type: INDEX

-- Name: gix_cfc_entity_master_ename; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX gix_cfc_entity_master_ename ON cfc.cfc_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: gix_kxp_entity_master_ename
-- Type: INDEX

-- Name: gix_kxp_entity_master_ename; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX gix_kxp_entity_master_ename ON labkxp1.labkxp_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

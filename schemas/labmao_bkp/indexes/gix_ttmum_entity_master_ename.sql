-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labmao_bkp.labmao_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

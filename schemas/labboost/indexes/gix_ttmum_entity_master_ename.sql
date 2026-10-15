-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labboost.labboost_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

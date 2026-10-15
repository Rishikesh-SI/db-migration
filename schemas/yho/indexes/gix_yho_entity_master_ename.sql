-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: gix_yho_entity_master_ename
-- Type: INDEX

-- Name: gix_yho_entity_master_ename; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX gix_yho_entity_master_ename ON yho.yho_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

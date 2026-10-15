-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: gix_pbl_entity_master_ename
-- Type: INDEX

-- Name: gix_pbl_entity_master_ename; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX gix_pbl_entity_master_ename ON pbl.pbl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

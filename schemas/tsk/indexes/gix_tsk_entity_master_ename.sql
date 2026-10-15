-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: gix_tsk_entity_master_ename
-- Type: INDEX

-- Name: gix_tsk_entity_master_ename; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX gix_tsk_entity_master_ename ON tsk.tsk_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

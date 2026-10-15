-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: gix_upp_entity_master_ename
-- Type: INDEX

-- Name: gix_upp_entity_master_ename; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX gix_upp_entity_master_ename ON utt.utt_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: gix_pcm_entity_master_ename
-- Type: INDEX

-- Name: gix_pcm_entity_master_ename; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX gix_pcm_entity_master_ename ON pcm.pcm_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

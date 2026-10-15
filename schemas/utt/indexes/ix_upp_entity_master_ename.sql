-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_entity_master_ename
-- Type: INDEX

-- Name: ix_upp_entity_master_ename; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_entity_master_ename ON utt.utt_entity_master USING btree (entity_name);


--

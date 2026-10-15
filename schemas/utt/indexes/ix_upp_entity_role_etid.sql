-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_entity_role_etid
-- Type: INDEX

-- Name: ix_upp_entity_role_etid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_entity_role_etid ON utt.utt_entity_role USING btree (entity_type_id);


--

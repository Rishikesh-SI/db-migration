-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_role_etid
-- Type: INDEX

-- Name: ix_tfa_entity_role_etid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_role_etid ON tfa.tfa_entity_role USING btree (entity_type_id);


--

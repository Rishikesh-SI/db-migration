-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_role_egid
-- Type: INDEX

-- Name: ix_tfa_entity_role_egid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_role_egid ON tfa.tfa_entity_role USING btree (entity_group_id);


--

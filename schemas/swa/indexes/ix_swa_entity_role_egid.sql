-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_entity_role_egid
-- Type: INDEX

-- Name: ix_swa_entity_role_egid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_entity_role_egid ON swa.swa_entity_role USING btree (entity_group_id);


--

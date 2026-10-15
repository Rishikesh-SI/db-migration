-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_entity_role_egid
-- Type: INDEX

-- Name: ix_mum_entity_role_egid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_entity_role_egid ON dhm.dhm_entity_role USING btree (entity_group_id);


--

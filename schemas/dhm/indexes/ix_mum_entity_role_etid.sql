-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_entity_role_etid
-- Type: INDEX

-- Name: ix_mum_entity_role_etid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_entity_role_etid ON dhm.dhm_entity_role USING btree (entity_type_id);


--

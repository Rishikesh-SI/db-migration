-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_role_etid
-- Type: INDEX

-- Name: ix_tcs_entity_role_etid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_role_etid ON tcs.tcs_entity_role USING btree (entity_type_id);


--

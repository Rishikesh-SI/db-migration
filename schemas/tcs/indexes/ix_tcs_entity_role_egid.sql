-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_role_egid
-- Type: INDEX

-- Name: ix_tcs_entity_role_egid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_role_egid ON tcs.tcs_entity_role USING btree (entity_group_id);


--

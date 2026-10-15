-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_entity_role_egid
-- Type: INDEX

-- Name: ix_mum_entity_role_egid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_entity_role_egid ON tmm.tmm_entity_role USING btree (entity_group_id);


--

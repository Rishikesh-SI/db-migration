-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_entity_role_egid
-- Type: INDEX

-- Name: ix_rfg_entity_role_egid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_entity_role_egid ON rfg.rfg_entity_role USING btree (entity_group_id);


--

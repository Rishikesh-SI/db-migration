-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_entity_role_etid
-- Type: INDEX

-- Name: ix_rfg_entity_role_etid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_entity_role_etid ON rfg.rfg_entity_role USING btree (entity_type_id);


--

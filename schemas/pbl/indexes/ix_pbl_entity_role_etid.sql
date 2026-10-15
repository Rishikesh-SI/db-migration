-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_entity_role_etid
-- Type: INDEX

-- Name: ix_pbl_entity_role_etid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_entity_role_etid ON pbl.pbl_entity_role USING btree (entity_type_id);


--

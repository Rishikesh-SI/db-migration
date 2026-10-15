-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_entity_role_egid
-- Type: INDEX

-- Name: ix_pbl_entity_role_egid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_entity_role_egid ON pbl.pbl_entity_role USING btree (entity_group_id);


--

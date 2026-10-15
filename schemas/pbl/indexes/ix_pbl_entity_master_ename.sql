-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_entity_master_ename
-- Type: INDEX

-- Name: ix_pbl_entity_master_ename; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_entity_master_ename ON pbl.pbl_entity_master USING btree (entity_name);


--

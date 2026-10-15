-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_master_ename
-- Type: INDEX

-- Name: ix_yho_entity_master_ename; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_master_ename ON yho.yho_entity_master USING btree (entity_name);


--

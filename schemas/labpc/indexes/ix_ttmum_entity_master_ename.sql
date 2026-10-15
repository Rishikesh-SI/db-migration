-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labpc.labpc_entity_master USING btree (entity_name);


--

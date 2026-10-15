-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_entity_master_ename
-- Type: INDEX

-- Name: ix_kxp_entity_master_ename; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_entity_master_ename ON labkxp1.labkxp_entity_master USING btree (entity_name);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_entity_master_ename
-- Type: INDEX

-- Name: ix_kxp_entity_master_ename; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_entity_master_ename ON labkxp.labkxp_entity_master USING btree (entity_name);


--

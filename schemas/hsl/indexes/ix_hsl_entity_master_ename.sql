-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_master_ename
-- Type: INDEX

-- Name: ix_hsl_entity_master_ename; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_master_ename ON hsl.hsl_entity_master USING btree (entity_name);


--

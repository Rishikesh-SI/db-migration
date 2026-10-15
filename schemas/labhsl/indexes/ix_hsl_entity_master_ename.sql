-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_entity_master_ename
-- Type: INDEX

-- Name: ix_hsl_entity_master_ename; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_entity_master_ename ON labhsl.labhsl_entity_master USING btree (entity_name);


--

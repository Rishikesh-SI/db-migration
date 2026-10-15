-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_labisl_v1_entity_master_ename
-- Type: INDEX

-- Name: ix_labisl_v1_entity_master_ename; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_labisl_v1_entity_master_ename ON labisl_v1.labisl_v1_entity_master USING btree (entity_name);


--

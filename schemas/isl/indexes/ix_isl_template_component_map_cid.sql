-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_template_component_map_cid
-- Type: INDEX

-- Name: ix_isl_template_component_map_cid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_template_component_map_cid ON isl.isl_template_component_map USING btree (component_id);


--

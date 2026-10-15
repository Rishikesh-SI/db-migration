-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labgt01_v1.labgt01_v1_template_component_map USING btree (component_id);


--

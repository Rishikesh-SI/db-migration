-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labdd_v1_30april24; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labdd_v1_30april24.labdd_v1_template_component_map USING btree (template_id);


--

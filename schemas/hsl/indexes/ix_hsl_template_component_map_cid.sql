-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_template_component_map_cid
-- Type: INDEX

-- Name: ix_hsl_template_component_map_cid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_template_component_map_cid ON hsl.hsl_template_component_map USING btree (component_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labilt.labilt_template_component_map USING btree (component_id);


--

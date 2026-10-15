-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labwf.labwf_template_component_map USING btree (component_id);


--

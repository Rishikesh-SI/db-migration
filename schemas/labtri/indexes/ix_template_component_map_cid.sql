-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labtri; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labtri.labtri_template_component_map USING btree (component_id);


--

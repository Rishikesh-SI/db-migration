-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON gsf.gsf_template_component_map USING btree (component_id);


--

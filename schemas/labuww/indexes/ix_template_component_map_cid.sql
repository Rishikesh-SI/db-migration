-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labuww.labuww_template_component_map USING btree (component_id);


--

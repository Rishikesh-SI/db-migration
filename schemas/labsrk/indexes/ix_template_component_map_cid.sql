-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labsrk.labsrk_template_component_map USING btree (component_id);


--

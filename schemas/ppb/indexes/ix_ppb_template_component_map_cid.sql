-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_template_component_map_cid
-- Type: INDEX

-- Name: ix_ppb_template_component_map_cid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_template_component_map_cid ON ppb.ppb_template_component_map USING btree (component_id);


--

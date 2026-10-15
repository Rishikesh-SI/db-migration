-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labisp.labisp_template_component_map USING btree (component_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_template_component_map_cid
-- Type: INDEX

-- Name: ix_pkl_template_component_map_cid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_template_component_map_cid ON pkl.pkl_template_component_map USING btree (component_id);


--

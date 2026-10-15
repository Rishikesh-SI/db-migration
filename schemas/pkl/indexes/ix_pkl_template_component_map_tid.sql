-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_template_component_map_tid
-- Type: INDEX

-- Name: ix_pkl_template_component_map_tid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_template_component_map_tid ON pkl.pkl_template_component_map USING btree (template_id);


--

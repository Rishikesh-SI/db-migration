-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labecn_bkp07062024.labecn_template_component_map USING btree (component_id);


--

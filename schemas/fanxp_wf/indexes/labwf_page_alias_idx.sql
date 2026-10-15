-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_page_alias_idx
-- Type: INDEX

-- Name: labwf_page_alias_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_page_alias_idx ON fanxp_wf.labwf_page USING btree (alias);


--

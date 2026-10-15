-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_user_role_role_id_idx
-- Type: INDEX

-- Name: labwf_user_role_role_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_user_role_role_id_idx ON fanxp_wf.labwf_user_role USING btree (role_id);


--

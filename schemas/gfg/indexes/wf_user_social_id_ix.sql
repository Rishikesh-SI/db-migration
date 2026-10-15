-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: wf_user_social_id_ix
-- Type: INDEX

-- Name: wf_user_social_id_ix; Type: INDEX; Schema: gfg; Owner: -
--

CREATE UNIQUE INDEX wf_user_social_id_ix ON gfg.wf_user USING btree (cf_clientid, social_id);


--

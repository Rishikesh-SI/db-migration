-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_team_category_ix
-- Type: INDEX

-- Name: ss_user_team_category_ix; Type: INDEX; Schema: eks; Owner: -
--

CREATE UNIQUE INDEX ss_user_team_category_ix ON eks.ss_user_team USING btree (cf_userid, cf_player_categoryid, cf_tourid);


--
